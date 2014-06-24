class Administracao::Patio < ActiveRecord::Base
  acts_as_list
 
  scope :na_data,lambda{|data| where("DATE_PART('DAY',data_entrada) = ? and DATE_PART('MONTH',data_entrada)=? and DATE_PART('YEAR',data_entrada)=?",data.day,data.month,data.year)}
  scope :em_aberto, ->{ where(state: "aberto")}

  has_many :postos

 state_machine :initial => :aberto do

    event :fechar do
      transition :aberto => :fechado
    end
  end

end
