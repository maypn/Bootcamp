Rock_Scissors_Paper <- function(){
  
  message("Welcome to Rock Scissors Paper game!")  
  choice <- c("Rock", "Scissors", "Paper")
  Win <- 0
  Loss <- 0
  Draw <- 0
  
  while (TRUE) {
    
    user_hand <- readline("Choose your move: Rock, Scissors, Paper, Quit: ")
    computer_hand <- sample(choice, size = 1)
    
    if (user_hand == "Rock" | user_hand == "Scissors" | user_hand == "Paper") {
        cat("User hand:    ", user_hand, "\n")
        cat("Computer hand:", computer_hand, "\n")
        
        if (user_hand == computer_hand) {
          cat("Draw!")
          Draw <- Draw +1
        } else if (user_hand == "Rock" & computer_hand == "Scissors"){
          cat("You win!")
          Win <- Win + 1
        } else if (user_hand == "Rock" & computer_hand == "Paper"){
          cat("You loss!")
          Loss <- Loss + 1
        } else if (user_hand == "Scissors" & computer_hand == "Rock"){
          cat("You loss!")
          Loss <- Loss + 1
        } else if (user_hand == "Scissors" & computer_hand == "Paper"){
          cat("You win!")
          Win <- Win + 1
        } else if (user_hand == "Paper" & computer_hand == "Rock"){
          cat("You win!")
          Win <- Win + 1
        } else {
          cat("You loss!")
          Loss <- Loss + 1
        }
        
        message("\nWin:  ", Win)
        message("Loss: ", Loss)
        message("Draw: ", Draw)
    
        
    } else if (user_hand == "Quit") {
      message("Good bye, see you next time!")
      break
    } else {
      message("Please choose your move")
    }
      
  }
}

Rock_Scissors_Paper()
