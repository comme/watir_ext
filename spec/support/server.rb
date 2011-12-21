#coding:utf-8
#require 'webrick'
#include WEBrick
#s = HTTPServer.new(
#    :port         => 2000,
#    :DocumentRoot => File.join(__FILE__, '..', "/html")
#)
#class HelloServlet < HTTPServlet::AbstractServlet
#def do_GET(req, res)
#  sleep req.query["timeout"].to_i rescue nil
#  appear_time         = req.query["time"].to_i
#  res['Content-type'] = 'text/html'
#  res.body            = %{
#      <html>
#      <head>
#<script type=\"text/javascript\">
#function add()
#{
#var button=document.createElement("input");
#button.setAttribute("type","button");
#button.setAttribute("name","button");
#button.setAttribute("value","button");
#document.body.appendChild(button);
#}
#function load()
#{
#var t=setTimeout(\"add()\",#{appear_time*1000})
#}
#</script>
#</head>
#      <body onload=load() >
#        Hello.You're calling from a #{req['User-Agent']}
#      <p>
#        I see parameters: #{req.query.keys.join(', ')}
#      </body>
#
#      </html>
#    }
#end

#end
#s.mount("/hello", HelloServlet)
#trap("INT") { s.shutdown }
#s.start
require 'webrick'
require 'timeout'

class WatirExtServer
  class HelloServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(req, res)
      sleep req.query["timeout"].to_i rescue nil
      appear_time         = req.query["time"].to_i
      res['Content-type'] = 'text/html'
      res.body            = %{
      <html>
      <head>
<script type=\"text/javascript\">
function add()
{
var button=document.createElement("input");
button.setAttribute("type","button");
button.setAttribute("name","button");
button.setAttribute("value","button");
document.body.appendChild(button);
}
function load()
{
var t=setTimeout(\"add()\",#{appear_time*1000})
}
</script>
</head>
      <body onload=load() >
        Hello.You're calling from a #{req['User-Agent']}
      <p>
        I see parameters: #{req.query.keys.join(', ')}
      </body>

      </html>
    }
    end
  end
  attr_reader :port, :run

  def initialize(port=22698)
    @run  = false
    @port = port
    @s    = WEBrick::HTTPServer.new(
        :Port         => @port,
        :DocumentRoot => File.join(__FILE__, '..', "/html"),
        :Logger       => WEBrick::Log.new("NUL"),
        :AccessLog    => [nil, nil]
    )
    @s.mount("/hello", HelloServlet)
  end

  def start(wait_forever = false)
    raise "popup server is running,can NOT run again" if @run
    @run      = true
    @s_thread = Thread.new do
      @s.start
    end
    wait
    @s_thread.join if wait_forever
  end

  def wait(timeout=10)
    Timeout.timeout(timeout, "after #{timeout} popup server still can NOT start") do
      loop do
        begin
          TCPSocket.new("127.0.0.1", @port)
          return true
        rescue
          sleep 0.5
        end
      end
    end
  end

  def stop
    @s.shutdown
    @run = false
  end

end

if $0 == __FILE__
  a = WatirExtServer.new
  a.start(true)
  #sleep 100
  #a.stop
end