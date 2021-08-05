function fn() {
  var env = karate.env; // get java system property 'karate.env'

  karate.log('karate.env system property was:', env);

   var config = {
        env: env,
        }

        config.baseURL = karate.properties['baseURL'] || 'https://reqres.in/api/'

        return config;
      }

