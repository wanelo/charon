require 'charon/deferrable'

module Charon
  class Publisher < ErrorRaisingDeferrable

  end
end

require 'charon/publishers/nfs_publisher'
