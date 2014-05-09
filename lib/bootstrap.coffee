keys = [

  # host to load things from - config will load this ...
  # config should prefer all keys from etcd over this
  "ETCD_HOST",

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






