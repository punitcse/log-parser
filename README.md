# Log Parser
Parse logs for a given log file and return the number of page views.

## How to use.

Run the ruby script
```ruby
./bin/parser.rb <your log file>
```
**NOTE:** I changed the script file inside `./bin` as I think all executables should be inside `bin` directory.

It returns the list of number of webpage views and unique views. Like
```yaml
/home 90 visits 
/index 80 visits
...
/about/2 8 unique views 
/index 5 unique views
```

## Design Approach

1. Follow the extreme programming approach. 
   Write test first and then let it fails write minimal code to pass then refactor it and again check if it pass. 
   Then write next test and so on.

2. Divide the problem into separate concerns: 
    - LogFile: Read file from a path and validate.
    - ContentParser: Parse content such as its easy to read and manipulate.
    - PageCounter: Counts the page visits and unique views.
    - View: Present the final output.
    
3. Initial implementation was to store each ip address and page in an OpenStruct. But then there would be repetition of ip address and page both.  
Which is not ideal for test as well as the memory. So I chose the hash which saves each page name as key and has multiple ip addresses.
Each ip address stores the count while reading the file. It would not be ideal solution if there are more requirements but as a concept of extreme programming [YAGNI](https://martinfowler.com/bliki/Yagni.html) we can discard it.
   

