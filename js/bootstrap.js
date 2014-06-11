// Generated by CoffeeScript 1.7.1
var keys;

keys = ["ETCD_HOST", "ETCD_PORT", "POSTGRES_HOST", "POSTGRES_PORT", "REDIS_PORT", "REDIS_HOST", "LOGGLY_CUSTOMER_TOKEN", "LOGGLY_SUBDOMAIN", "LOGGLY_USERNAME", "LOGGLY_PASSWORD", "RABBIT_HOST", "RABBIT_PORT"];


/*
1.) Bootstrap config
2.) ADD Any user configuration into the config
3.) Startup services [postgres, rabbit, redis, daemon-trigger, loggly, etcd]
4.) Check in with etcd 
5.) Pass to callback

first look into multi-config / etcd and then get this working
would like the ability to add an etcd namespace ...
  would then read from the global namespace if not overridden
 */
