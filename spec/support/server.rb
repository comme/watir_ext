#coding:utf-8
require 'webrick'
include WEBrick
s = HTTPServer.new(
    :port         => 2000,
    :DocumentRoot => File.join(__FILE__, '..', "/html")
)
class HelloServlet < HTTPServlet::AbstractServlet
  def do_GET(req, res)
    sleep req.query["timeout"].to_i rescue nil
    appear_time = req.query["time"].to_i
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
s.mount("/hello", HelloServlet)
trap("INT") { s.shutdown }
s.start