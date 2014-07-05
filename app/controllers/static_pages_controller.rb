class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def qrcode
 	@qr = RQRCode::QRCode.new('http://www.baidu.com/')
  end
end
