include("common.jl")

@info "Loading words from book"
words = get_words()

@info "$(length(words)) total words and $(unique_words(words)) unique words"
@info "10 most popular words are:" most_popular(words)
@info "10 longest words are:" longest_word(words, 10)
@info "10 longest palindromes are:" longest_palindrome(words, 5)
