/*
 * Copyright (C) 2021 "IoT.bzh"
 * Author: Valentin Lefebvre <valentin.lefebvre@iot.bzh>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
*/

///////////////////////////////////////////////////////////////////////////////
//                             INCLUDES                                      //
///////////////////////////////////////////////////////////////////////////////

// Usefull classical include
#include<iostream>
#include <wrap-json.h>
#include <string.h>

// afb include
#define AFB_BINDING_VERSION 3
#include <afb/afb-binding.h>
#include <ctl-plugin.h>
#include <ctl-config.h>
#include <signal-composer.hpp>

///////////////////////////////////////////////////////////////////////////////
//                             DEFINES                                       //
///////////////////////////////////////////////////////////////////////////////

#define API_NAME "@PROJECT_NAME@"
#define DTB_CLASS "@DEMO_SENSOR@"

#define DTB_API "redis"
#define DTB_INSERT "ts_jinsert"
#define DEFAULT_RETENTION 1
#define MICRO 1000000

extern "C"
{
    CTLP_CAPI_REGISTER(API_NAME);

    /**
     * @brief Log if a response has been failed
     * 
     * @param closure   the user defined closure pointer 'closure'
     * @param object    a JSON object returned (can be NULL)
     * @param error     a string not NULL in case of error but NULL on success
     * @param info      a string handling some info (can be NULL)
     * @param api       the api
     */
    static void _response_cb(void *closure, json_object *object, const char *error, const char *info, afb_api_t api) {
        if (error) {
            AFB_API_ERROR(afbBindingRoot, "An error occurred when sending data to redis-tsdb-binding: %s", error);
            return;
        }
        AFB_API_DEBUG(afbBindingRoot, "Data has been successfully send to redis-tsdb-binding");
    }

    /**
     * @brief create request and send it to redis to store data into database. 
     * Store data into the class named by the signal id
     * 
     * @param[in] sig - Signal context
     * @param[in] eventJ - Event in json_object
     * @return none
     */ 
    static void _push_data(Signal *sig, json_object *eventJ) {
        json_object *data_json = NULL;
        int ret = 0;
        const char *signal_id = sig->id().c_str();
        
        // Create the json to send to redis
        ret = wrap_json_pack(&data_json, "{ss so ss}"
                        , "class", signal_id
                        , "data", eventJ
                        , "timestamp", "*");
        if (ret < 0) {
            AFB_ERROR("[%s] Failed to wrap data for redis. Event json: %s", __func__, json_object_get_string(eventJ));
            return;
        }
        eventJ = json_object_get(eventJ);

        // Call insert verb of redis API
        afb_api_call(afbBindingRoot, DTB_API, DTB_INSERT, data_json, _response_cb, NULL);     
    }

    ///////////////////////////////////////////////////////////////////////////////
    //                             CONTROLLER FUNCTIONS                          //
    ///////////////////////////////////////////////////////////////////////////////

    /**
    * @brief Callback called for each event received from low level binding. 
    *  It will push data to redis-tsdb-binding
    * 
    * @param[in] source - data's client
    * @param[in] argsJ - Arguments in JSON
    * @param[in] eventJ - event in JSON 
    * @retval none
    * */
    CTLP_CAPI(catch_event_cb, source, argsJ, eventJ) {
        struct signalCBT* ctx;
        Signal *sig;

        // Get context and plugin signal
        ctx = (struct signalCBT*)source->context;
        sig = (Signal*) ctx->aSignal;

        // Process data from the signal
        _push_data(sig, eventJ);

        return 0;
    }
}