@password = '123'
@balance = 1_234_567
@login_tries = 0

puts "Bienvenido a su banco Python Bank \n \n"

def recive_password
  puts 'por favor digite su clave'
  gets.chomp
end

def valid_password?
  @password == recive_password
end

def available_for_withdrawal(withdrawal_amount)
  @balance > withdrawal_amount
end

def withdrawal
  puts 'digite el monto que desea retirar'
  withdrawal_amount = gets.chomp.to_i
  if available_for_withdrawal(withdrawal_amount)
    @balance -= withdrawal_amount
    sleep 1
    puts 'procesando.... '
    sleep 3
    puts "usted a retirado $#{withdrawal_amount}"
    puts "su nuevo saldo es de $#{@balance}"
    puts 'gracias por usar nuestro servicio, vuelva pronto'
    puts 'presione 1 para salir'
    valid_number = gets.chomp
    if valid_number == '1' 
     exit
    else
      puts 'es estupido y no sabe seguir instrucciones'
    end
  end
end

def deposit 
  puts 'valide su contraseña'
  if valid_password?
    puts 'digite cuanto desea depositar'
    deposit_amount = gets.chomp.to_i
    @balance += deposit_amount
    sleep 1
    puts 'procesando.... '
    sleep 3
    puts "usted a depositado $#{deposit_amount}"
    puts "su nuevo saldo es de $#{@balance}"
    puts 'gracias por usar nuestro servicio, vuelva pronto'
    exit
  else
  end
end

def show_balance
  puts "su nuevo saldo es de $#{@balance}"
  puts 'gracias por usar nuestro servicio, vuelva pronto'
  exit
end


while @login_tries < 3 do
  if valid_password?
    puts "Contraseña aceptada, en qué lo podemos ayudar hoy: \n\n 1. Retirar \n\n 2. Depositar \n\n 3. Ver saldo \n\n 4. Salir"
    puts 'digite el número del proceso que desea realizar'
    option = gets.chomp

    case option
    when '1'
      withdrawal
    when '2'
      deposit 
    when '3'
      show_balance
    else
      exit
    end
  else
    @login_tries += 1
    puts "clave incorrecta, le queda #{3 - @login_tries}" 
  end
  if @login_tries == 3
    puts 'sus intentos han terminado, adios. Vuelva pronto'
    exit
  end
end