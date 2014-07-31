class Horas

    def horas_extras(horas)
        
        horas_normais = 2
        h = 0

        if (horas_normais+horas) > 8
        	puts "#{horas_normais} + #{horas} sou Maior: #{horas_normais+horas}"
            
            hora_extra =  ((horas_normais+horas)-8)
            hora_normal = (((horas_normais+horas)-hora_extra)-horas_normais)


            puts "Agora sou #{hora_extra} extra"
            puts "Agora Sou #{hora_normal} normal"

        elsif (horas_normais+horas) <=8
            puts "EU SOU A HORA EXATA"
        else
        	puts "#{horas_normais} + #{horas} Sou Menor: #{horas_normais+horas}"
        end



    end

end