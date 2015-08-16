class String
  def to_email_url
    if self.include?("gmail")
      "http://gmail.google.com/"
    else
      "http://mail.#{self.split('@')[1]}"
    end
  end
end
