exports.missingParameters = (keys, obj) =>

  missing = (key for key in keys when not obj[key]?)
  return if missing.length > 0 then missing else null

