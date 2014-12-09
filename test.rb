$LOAD_PATH << './lib'
require 'charon'
Charon.before_command_load
logger = Charon.logger
logger.debug('test!')
