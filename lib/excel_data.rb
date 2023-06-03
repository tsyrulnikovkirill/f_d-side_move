require 'axlsx'

class ExcelData

  def initialize
    @p = Axlsx::Package.new
    @wb = @p.workbook
    @lines = []
  end

  def head_text(sheet)
    sheet.add_row ['t, с', 'm, кг' ,'P, Н', 'V, м/с', 'M', 'Cr','Cx', 'α_pr, град',
                   'ψ, град', 'x, м', 'z, м']
  end

  def create_line(parameters)
    @lines << parameters
  end

  def create_sheet(sheet_name)
    @wb.add_worksheet(:name => sheet_name) do |sheet|
      head_text(sheet)
      @lines.each do |line|
        sheet.add_row(line)
      end
    end
  end

  def clean
    @lines = []
  end

  def save
    @p.serialize 'data/_Результаты расчета_.xlsx'
  end
end
