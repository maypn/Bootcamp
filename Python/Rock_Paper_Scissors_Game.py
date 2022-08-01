import random
user_hand = []

def rock_paper_scissors():

    name = input("What is your name? ")
    print(f"\n Hi! {name}. Welcome to rock paper scissors game.\n Please choose your move: rock, paper, scissors (type quit to exit the game) \n Let's Play!")

    draw = 0
    win = 0
    lose = 0

    while True:

        user_hand = input("\n Choose rock, paper, scissors: ")

        if user_hand == "rock" or user_hand == "paper" or user_hand == "scissors": 
            
            print(f"\n > user_hand: {user_hand}")
            computer_hand = random.choice(["rock", "paper", "scissors"])
            print(f" > computer_hand: {computer_hand}")

            if user_hand == computer_hand:
                print(" > Draw!")
                draw = draw + 1
            elif user_hand == "rock" and computer_hand == "paper":
                print(" > You lose!")
                lose = lose + 1
            elif user_hand == "rock" and computer_hand == "scissors":
                print(" > You win!")
                win = win + 1
            elif user_hand == "paper" and computer_hand == "rock":
                print(" > You win!")
                win = win + 1
            elif user_hand == "paper" and computer_hand == "scissors":
                print(" > You lose!")
                lose = lose + 1
            elif user_hand == "scissors" and computer_hand == "rock":
                print(" > You lose!")
                lose = lose + 1  
            else:
                print(" > You win!")
                win = win + 1

            print(f"\n win = {win}")
            print(f" lose = {lose}")
            print(f" draw = {draw}")

        elif user_hand == "quit":
            print(f"\n Goodbye {name} :D")
            print(f"\n win = {win}")
            print(f" lose = {lose}")
            print(f" draw = {draw}")
            break
        else:
            print("\n > Please try again")
