require 'date'

#Verifica si el string es un numero
def is_number string
  1 if Float(string) rescue 0
end

#Verifica si la longoitud es correcta
def longitud long
  if long == 7 then
    return 1
  else
    return 0
  end
end

#Verifica si es fecha
def fecha fech
  1 if Date.parse(fech) rescue 0
end

#Verifica si es hora
def hora (fech, tiempo)
  1 if DateTime.parse(fech + tiempo) rescue 0
end

#Verifica si es dia de pico y placa
def dayPicoPlaca(day, digitPlate)
  if ((day == 1 && digitPlate == 1) || (day == 1 && digitPlate == 2)) ||
     ((day == 2 && digitPlate == 3) || (day == 2 && digitPlate == 4)) ||
	 ((day == 3 && digitPlate == 5) || (day == 3 && digitPlate == 6)) ||
	 ((day == 4 && digitPlate == 7) || (day == 4 && digitPlate == 8)) ||
	 ((day == 5 && digitPlate == 0) || (day == 5 && digitPlate == 9)) then
    return 1
  else
    return 0
  end
end

#Verifica si es hora de pico y placa
def dateTimePicoPlaca(hour, minute)
  if (hour.between?(7,9) && minute <=930) || (hour.between?(16,19) && minute <=1930) then
    return 1
  else
    return 0
  end
end

#Envia resultado final
def PicoPlaca(dayWeek, timeWeek)
  if dayWeek ==1 and timeWeek == 1 then
    return "Tiene Pico y Placa"
  else 
    return "Puede Circular"
  end 
end

print "Please enter a license plate number (format AAA9999): "
licensePlate = gets.chomp

longitudLic= longitud(licensePlate.length)
#Permite ingresar placas validas
while not (is_number(licensePlate[0,1]) == 0 && is_number(licensePlate[1,2]) == 0 && is_number(licensePlate[2,3]) == 0 && is_number(licensePlate[3,4]) == 1  && is_number(licensePlate[4,5]) == 1 && is_number(licensePlate[5,6]) == 1 && is_number(licensePlate[6,7]) == 1 && longitudLic == 1)
  print "Please enter a valid license plate number (format AAA9999): "
  licensePlate = gets.chomp
  
  longitudLic= longitud(licensePlate.length)
end

print "Please enter a date (format YYYYMMDD): "
date = gets.chomp

dateInput = fecha(date)
#Permite ingresar fechas validas
while dateInput == 0
  print "Please enter a valid date (format YYYYMMDD): "
  date = gets.chomp
  
  dateInput = fecha(date)
end

print "Please enter time (format HHMM 24h): "
dateTime = gets.chomp

dateTimeInput = hora(date, dateTime)
#Permite ingresar horas validas
while not (dateTimeInput == 1 && is_number(dateTime) == 1)
  print "Please enter a valid time (format HHMM 24h): "
  dateTime = gets.chomp
  
  dateTimeInput = hora(date, dateTime)
end

#Se obtiene el ultimo digito
lastDigit = licensePlate[6, licensePlate.length]  

#Se convierte a fecha
dateConv = Date.parse(date)

#Se convierte a hora
dateTimeConv = DateTime.parse(date + dateTime)
hourTime = "#{dateTimeConv.hour}#{dateTimeConv.min}"


respDay = dayPicoPlaca(dateConv.wday.to_i, lastDigit.to_i)
respHour = dateTimePicoPlaca(dateTimeConv.hour.to_i, hourTime.to_i)
resPicoPlaca = PicoPlaca(respDay,respHour)

print "\n"
print resPicoPlaca
print "\n"

