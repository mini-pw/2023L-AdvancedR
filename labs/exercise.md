`library(lobstr) 	`

### Q-1:
`1:5^2`
`1:5*2`

### Q0: Fix each of the following common data frame subsetting errors:

`mtcars[mtcars$cyl = 4, ]`

`mtcars[-1:4, ]`

`mtcars[mtcars$cyl <= 5]`

`mtcars[mtcars$cyl == 4 | 6, ]`

### Q1: Why is 1 == "1" true? Why is -1 < FALSE true? Why is "one" < 2 false?

### Q1.5: What does the following code return? Why? Describe how each of the three c’s is interpreted.
```
c <- 10
c(c = c)
```

### Q2: What does dim() return when applied to a 1-dimensional vector? When might you use NROW() or NCOL()?

### Q3: Can you have a data frame with zero rows? What about zero columns?

### Q4: Explain the relationship between a, b, c, and d in the following code:

```
a <- 1:10
b <- a
c <- b
d <- 1:10
```

### Q5: Brainstorm as many ways as possible to extract the third value from the cyl variable in the mtcars dataset.


### Q6: Why does the following code work?

```
x <- 1:10
if (length(x)) "not empty" else "empty"
#> [1] "not empty"
```
```
x <- numeric()
if (length(x)) "not empty" else "empty"
#> [1] "empty"
```


### Q7: When the following code is evaluated, what can you say about the vector being iterated?

```
xs <- c(1, 2, 3)
for (x in xs) {
  xs <- c(xs, x * 2)
}
xs
#> [1] 1 2 3 2 4 6
#> 
```

### Q8: What does the following code tell you about when the index is updated?

```
for (i in 1:3) {
  i <- i * 2
  print(i) 
}
#> [1] 2
#> [1] 4
#> [1] 6
#> 
```

###  Q9: The following code accesses the mean function in multiple ways. Do they all point to the same underlying function object? Verify this with lobstr::obj_addr().

```
mean
base::mean
get("mean")
evalq(mean)
match.fun("mean")
```

### Q10: Test your knowledge of vector coercion rules by predicting the output of the following uses of c():

```
c(1, FALSE)      
c("a", 1)        
c(TRUE, 1L)      
```

### Q11: What sort of object does table() return? What is its type? What attributes does it have? How does the dimensionality change as you tabulate more variables?

### Q12:  What does df[is.na(df)] <- 0 do? How does it work?

### Q13: What does the following function return? Make a prediction before running the code yourself.

```
f <- function(x) {
  f <- function(x) {
    f <- function() {
      x ^ 2
    }
    f() + 1
  }
  f(x) * 2
}
f(10)
```

### Q14: Write your own version of + that pastes its inputs together if they are character vectors but behaves as usual otherwise. In other words, make this code work:

```
1 + 2
#> [1] 3

"a" + "b"
#> [1] "ab"
#> 
```

### Q15: Create infix versions of the set functions intersect(), union(), and setdiff(). You might call them %n%, %u%, and %/% to match conventions from mathematics.




