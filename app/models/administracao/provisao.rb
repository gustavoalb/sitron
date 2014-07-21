class Administracao::Provisao < ActiveRecord::Base
  belongs_to :veiculo
  belongs_to :requisicao

    scope :na_data,lambda{|data| where("DATE_PART('DAY',data_aprovisionamento) = ? and DATE_PART('MONTH',data_aprovisionamento)=? and DATE_PART('YEAR',data_aprovisionamento)=? and DATE_PART('HOUR',data_aprovisionamento)=?",data.day,data.month,data.year,data.to_datetime.hour)}

end
