WickedPdf.config = {
    :exe_path => (Rails.env.development? ? Rails.root.join('bin', 'wkhtmltopdf').to_s : '/usr/local/rvm/gems/ruby-1.9.3-p484/bin/wkhtmltopdf')
}
