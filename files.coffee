FS = require 'fs'
PATH = require 'path'

class Files
 constructor: (@dir) ->
  @dir = PATH.normalize @dir
  try
   FS.mkdirSync @dir
  try
   FS.accessSync @dir
  catch
   throw new Error "Scheduler directory #{@dir} is missing"

 _path: (id) -> PATH.resolve @dir, "#{id}.json"
 read: (id) ->
  try
   data = FS.readFileSync (@_path id), encoding: 'utf8'
   return JSON.parse data
  return null

 write: (id, json) ->
  data = JSON.stringify json
  FS.writeFileSync (@_path id), data, encoding: 'utf8'

module.exports = Files
