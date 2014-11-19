require 'open3'
class DiscantExecutor
  @discantJarPath = "#{Rails.root}/lib/discant_executor/Discant_linux.jar"
  class << self
    attr_accessor :discantJarPath
  end

  def self.exec(programPath, inputPath)
    #TODO: add timeout
    #check this gist: https://gist.github.com/lpar/1032297
    #http://blog.bigbinary.com/2012/10/18/backtick-system-exec-in-ruby.html
    if inputPath
      cmd = "java -jar #{discantJarPath} #{programPath} < #{inputPath}"
    else
      cmd = "java -jar #{discantJarPath} #{programPath}"
    end
    out, err, exit_status = nil, nil, nil

    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      out = stdout.read
      err = stderr.read
      exit_status = wait_thr.value
      puts "stdout is: " + out
      puts "stderr is: " + err
      puts "exit status: " + exit_status.to_s
    end
    return {
      stdout: out,
      stderr: err,
      exit_status: exit_status
    }
  end
end