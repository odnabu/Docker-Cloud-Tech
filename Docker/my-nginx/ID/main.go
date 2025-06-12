package main
import (
    "encoding/json"
    "log"
    "math/rand"
    "net/http"
)
func main() {
    http.HandleFunc("/idea", ideaHandler)
    log.Println("Server starting on port 8080...")
    err := http.ListenAndServe(":8080", nil)

    if err != nil {
        log.Fatalf("Server failed to start: %v", err)
    }
}

func ideaHandler(w http.ResponseWriter, r *http.Request) {
    ideas := []string{
        "Develop a sustainable urban farming system.",
        "Create an AI-powered personal assistant for mental well-being.",
        "Design a modular, affordable housing solution.",
    }
    randomIndex := rand.Intn(len(ideas))
    randomIdea := ideas[randomIndex]
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(randomIdea)
}

