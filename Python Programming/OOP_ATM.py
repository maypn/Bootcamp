class ATM:
    def __init__(self, account_name, account_pin, balance=50000):
        self.account_name = account_name
        self.account_pin = account_pin
        self.balance = balance

    def __str__(self):
        return "I'm Automated Teller Machine"

    # ATM method
    ## 1 Deposit
    def deposit(self, amount):
        print(f"Deposit: {amount} THB to your account")
        self.balance += amount

    ## 2 Withdraw
    def withdraw(self, amount):

        count = 0
        pin = self.account_pin

        while count < 3:

            user_pin = input("\nPlease enter your pin: ")

            if pin == int(user_pin):
                print(f"Withdraw: {amount} THB from your account")
                self.balance -= amount
                break         
            else:
                print("Incorrect pin. Please try again")
                count = count+1

    ## 3 Balance Checking
    def check_balance(self):

        count = 0
        pin = self.account_pin

        while count < 3:

            user_pin = input("\nPlease enter your pin: ")

            if pin == int(user_pin):
                print(f"Balance: {self.balance} THB")
                break         
            else:
                print("Incorrect pin. Please try again")
                count = count+1

    ## 4 Bill Payment
    def bill(self):

        count = 0
        pin = self.account_pin

        while count < 3:

            user_pin = input("\nPlease enter your pin: ")

            if pin == int(user_pin):

                services = input("\nPlease select services (Internet/ Utilities): ")

                if services == "Utilities":
                    print("Amount: 192.60 THB")
                    tr_confirm = input(f"Please confirm the transaction (confirm/ deny): ")
                    if tr_confirm == "confirm":
                        print("\nBill payment completed.")
                        self.balance -= float("192.60")
                        break
                    else:
                        print("\nPlease re-start your transaction from the beginning.")
                elif services == "Internet":
                    print("Amount: 319.93 THB")
                    tr_confirm = input(f"Please confirm the transaction (confirm/ deny): ")
                    if tr_confirm == "confirm":
                        print("\nBill payment completed.")
                        self.balance -= float("319.93")
                        break
                    else:
                        print("\nPlease re-start your transaction from the beginning.")     
                else:
                    print("\nNot found the services. Please try again")

            else:
                print("Incorrect pin. Please try again")
                count = count+1
   
    ## 5 Transfer
    def transfer(self):

        count = 0
        pin = self.account_pin

        while count < 3:

            user_pin = input("\nPlease enter your pin: ")

            if pin == int(user_pin):

                tr_bank = input("\nBank: ")
                tr_account = input("Account name: ")
                tr_amount = input("Amount: ")
                tr_confirm = input(f"Please confirm the transaction (confirm/ deny): ")
                
                if tr_confirm == "confirm":
                    print("\nTransfer Completed.")
                    self.balance -= int(tr_amount)
                    break
                else:
                    print("\nPlease re-start your transaction from the beginning.")
            
            else:
                print("Incorrect pin. Please try again")
                count = count+1
