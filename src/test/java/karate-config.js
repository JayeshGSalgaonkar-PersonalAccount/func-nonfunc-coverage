function fn() {

  karate.configure('connectTimeout', 90000);
  karate.configure('readTimeout', 90000);
  var env = karate.env; // get java system property 'karate.env'
//  karate.configure('ssl', true);
  karate.log('karate.env system property was:', env);
  if (!env) {
      env = 'preprod'; // a custom 'intelligent' default
    }

   var config = {}

    if (env == 'dev')
        config.baseURL = karate.properties['baseURL'] || 'https://devma.ntuc.org.sg/api/'
    else if(env == 'preprod')
        config.baseURL = karate.properties['baseURL'] || 'https://apimpre.ntuc.org.sg/api/'
    else if(env == 'uat')
        config.baseURL = karate.properties['baseURL'] || 'https://uatma.ntuc.org.sg/api/'
    else
        config.baseURL = karate.properties['baseURL']
//By default run in dev environment
    return config;
      }