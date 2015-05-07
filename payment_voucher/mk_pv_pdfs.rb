#!/usr/bin/env ruby

# SG会計のための Payment Voucher 作成 スクリプト / tsv/pdfフォーマット都合、自社専用
# http://wkhtmltopdf.org/ をいれておく & gem install pdfkit しておく必要あり。
# - 20150507 Masakazu OHNO 
# 
# 
require "PDFKit"
require 'csv'
require 'pp'
 
TSV_FILE_NAME = 'accounting_data.tsv'
COMPANY_NAME = 'A-FIS PTE LTD'
YOUR_NAME = 'Director Masakazu OHNO'
OUTPUT_DIR = './output'
SIGNS_DIR = './signs'

CSV.foreach(TSV_FILE_NAME, :col_sep => "\t") do |row|
    e_number = row[0]
    date = row[1]
    ammount = row[2]
    payee = row[5]
    desc = row[6]
    i_number = row[10]
    if i_number.to_s.strip=='' and e_number.to_s.strip!='Bank'
      if payee.to_s.strip!='' and desc.to_s.strip!=''
        
        sign_png = File.expand_path("#{SIGNS_DIR}/ohno.png")
        
        htmlString = <<-EOS
        <style>
          <!--
          table {margin:0; padding:0;}
          td {
            padding:5px;
            border:1px solid #ccc;
            }
          tr {padding:0; margin:0;}
          -->
        </style>
        <h1 style="font-family:'ヒラギノ角ゴ Pro W3','Hiragino Kaku Gothic Pro',sans-serif;">Payment Voucher </h1>
        <div style="text-align:right">
          #{COMPANY_NAME}
        </div>
        <div style="text-align:right">
            Date: #{date}
        </div>
        <br />
        <div style="text-align:right">
            <span>
              Cash 
            </span>
            / 
            <span style="border:1px solid #000; border-radius:50%; padding:3px;" >
              Credit
            </span>
        </div>
        <div>
          PAY TO : #{payee}
        </div>
        <div style="text-align:center;">
            <table style="border:1px solid; width:80%">
              <tr style="background-color: #ddd; text-align:center;" >
                <td > Description </td>
                <td> Ammount </td>
              <tr>
              </tr>
                <td> #{desc} </td>
                <td> #{ammount} </td>
              </td>
              </tr>
                <td>　</td>
                <td>　</td>
              </td>
              </tr style="background-color: #ddd;">
                <td style="text-align:right;"> Total </td>
                <td> #{ammount} </td>
              </tr>
            </table>
        </div>
        <div style="text-align:right">
            Payment Approved By:
            <br />
            #{COMPANY_NAME}
            <br />
            #{YOUR_NAME}
            <br />
            <img src="#{sign_png}" width="100">
        </div>
        EOS
        ammount_sgd = ammount.gsub('S$','SGD')
        file = open("#{OUTPUT_DIR}/#{e_number}-#{date}-#{ammount_sgd}.pdf","w")
        file.puts PDFKit.new(htmlString).to_pdf
        file.close
        
        puts "#{OUTPUT_DIR}/#{e_number}-#{date}-#{ammount_sgd}.pdf"
        
        #exit
        
      end
    end
end




