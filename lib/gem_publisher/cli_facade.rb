require "shellwords"
require "open3"

module GemPublisher
  class CliFacade
    Error = Class.new(RuntimeError)

    def execute(*arguments)
      cmd = Shellwords.join(arguments)
      Open3.popen3(cmd) do |_i, stdout, stderr, thr|
        output = [stderr.read, stdout.read].join.strip
        raise Error, output if thr.value.exitstatus > 0
        return output
      end
    end
  end
end
