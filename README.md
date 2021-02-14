# Log Parser
Parse logs for a given log file and return the number of page views.

## How to use.

Run the ruby script
```ruby
./parser.rb <your log file>
```
Returns the list of number of webpage views and unique views. Like
```yaml
/home 90 visits 
/index 80 visits
...
/about/2 8 unique views 
/index 5 unique views
```
