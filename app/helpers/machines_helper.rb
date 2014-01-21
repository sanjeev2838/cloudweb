module MachinesHelper
  def generate_csv

    book = Spreadsheet::Workbook.new
    default_format = Spreadsheet::Format.new :color => :black, :size => 8,:horizontal_align=> :center
    book.default_format = default_format
    data = book.create_worksheet :name =>"Machines"
    bold = Spreadsheet::Format.new :weight => :bold,:horizontal_align=> :center
    header = Spreadsheet::Format.new :weight => :bold
    index=0
    data.row(index).default_format=bold
    alignment = Spreadsheet::Format.new :align => :merge,:size=>8,:horizontal_align=> :center

    data.merge_cells(0,0,0,7)
    row_index=2
    column_index=0
    data[0,0]="Machines"
    data.row(row_index).default_format=bold
    14.times do |n|
      data.column(n).width = 20
    end
    data[row_index,column_index]= "Serial Id"
    data[row_index,column_index+1]= "Firmware"
    data[row_index,column_index+2]="HW config"
    data[row_index,column_index+3]="Mac Address"
    data[row_index,column_index+4]="IP Address"
    data[row_index,column_index+5]="Boot Loader"
    data[row_index,column_index+6]="Colour"
    data[row_index,column_index+7]="Status"

    blob = StringIO.new('')
    book.write(blob)
    blob.rewind
    blob.read
  end

end
