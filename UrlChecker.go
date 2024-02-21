package main

import (
 "fmt"
 "io/ioutil"
 "net/http"
 "net/url"
 "regexp"
 "strings"
)

func checkURL(url, regex string, proxyURL *url.URL) bool {
 transport := &http.Transport{
  Proxy: http.ProxyURL(proxyURL),
 }

 client := &http.Client{Transport: transport}
 req, err := http.NewRequest("GET", url, nil)
 if err != nil {
  fmt.Printf("Erreur lors de la création de la requête %s : %s\n", url, err)
  return false
 }

 req.Header.Set("User-Agent", "Internal availability checker v0.04")

 resp, err := client.Do(req)
 if err != nil {
  fmt.Printf("Erreur lors de la requête %s : %s\n", url, err)
  return false
 }
 defer resp.Body.Close()

 body, err := ioutil.ReadAll(resp.Body)
 if err != nil {
  fmt.Printf("Erreur lors de la lecture du corps de la réponse %s : %s\n", url, err)
  return false
 }

 match, _ := regexp.MatchString(regex, string(body))
 return match
}

func main() {
 proxyURL, err := url.Parse("http://10.0.0.99:8080")
 if err != nil {
  fmt.Println("Erreur lors de la création de l'URL du proxy :", err)
  return
 }

 fileContent, err := ioutil.ReadFile("votre_fichier.txt")
 if err != nil {
  fmt.Println("Erreur lors de la lecture du fichier :", err)
  return
 }

 lines := strings.Split(string(fileContent), "\n")
 for _, line := range lines {
  parts := strings.Split(line, ",")
  if len(parts) == 2 {
   url := strings.TrimSpace(parts[0])
   regex := strings.TrimSpace(parts[1])
   if checkURL(url, regex, proxyURL) {
    fmt.Printf("L'URL %s est accessible et satisfait la regex.\n", url)
   } else {
    fmt.Printf("L'URL %s n'est pas accessible ou ne satisfait pas la regex.\n", url)
   }
  }
 }
}
