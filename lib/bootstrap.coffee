keys = [
  # host to load things from - config will load this ...
  # config should prefer all keys from etcd over this
  "ETCD_HOST", # this should be read in the config module automatically

  "ETCD_PORT", # this should be read in the config module automatically

  # update postgres
  "POSTGRES_HOST",
  "POSTGRES_PORT",
  
  # redis
  "REDIS_PORT",
  "REDIS_HOST",

  # loggly credentials 
  "LOGGLY_CUSTOMER_TOKEN", 
  "LOGGLY_SUBDOMAIN", 
  "LOGGLY_USERNAME", 
  "LOGGLY_PASSWORD" 

  # rabbit credentials / configuration
  "RABBIT_HOST", 
  "RABBIT_PORT",
]

###
1.) Bootstrap config
2.) ADD Any user configuration into the config
3.) Startup services [postgres, rabbit, redis, daemon-trigger, loggly, etcd]
4.) Check in with etcd 
5.) Pass to callback

first look into multi-config / etcd and then get this working
would like the ability to add an etcd namespace ...
  would then read from the global namespace if not overridden

###

