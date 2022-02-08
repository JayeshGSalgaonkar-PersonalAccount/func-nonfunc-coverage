function fn() {

  karate.configure('connectTimeout', 90000);
  karate.configure('readTimeout', 90000);
  var env = karate.env;
    // get java system property 'karate.env'
    //  karate.configure('ssl', true);
  karate.log('karate.env system property was:', env);
  if (!env) {
      env = 'uat'; // a custom 'intelligent' default
    }

   var config = {}

    if (env == 'dev'){
        config.baseURL = karate.properties['baseURL'] || 'https://devma.ntuc.org.sg/api/'
        config.xAPIKEY = 'bm1wSW50ZXJuYWxTZXJ2aWNl'
        }
    else if(env == 'preprod'){
        config.baseURL = karate.properties['baseURL'] || 'https://apimpre.ntuc.org.sg/api/'
        config.xAPIKEY = 'MjIwYWFlMTItYzg0NC00NTU4LWIyZjAtNjc2Y2Y5ZmMzNzUw'
        }
    else if(env == 'uat'){
        config.baseURL = karate.properties['baseURL'] || 'https://uatma.ntuc.org.sg/api/'
        config.xAPIKEY = 'MzI2YjUyNzYtOGY2MS00MjhlLWFjNTAtOGQ1ZjU0YmE2MjI2'
        }
    else  if(env == 'prod')
        config.baseURL = karate.properties['baseURL'] || 'https://ma.ntuc.org.sg/api/'
    else {
         config.baseURL = karate.properties['baseURL'] || 'https://devma.ntuc.org.sg/api/'
         config.xAPIKEY = 'bm1wSW50ZXJuYWxTZXJ2aWNl'
         }
//  By default run in dev environment
    return config;
      }