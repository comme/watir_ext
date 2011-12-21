require 'iconv'
class String
  def to_gbk
    begin
      self.unpack("U*")
      Iconv.iconv('GBK', 'UTF-8', self).at(0).to_s
    rescue ::ArgumentError
      self
    end
  end

  def to_utf8
    begin
      Iconv.iconv('UTF-8', 'GBK', self).at(0)
    rescue ::ArgumentError
      self
    end
  end
end