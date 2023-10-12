#=
    Clojure in a nutshell by James Trunk
    https://www.youtube.com/watch?v=C-kF25fWTO8
=#

import HTTP
import StatsBase

fetch_book(url="https://www.gutenberg.org/files/2701/2701-0.txt") = HTTP.get(url)
get_lines(book=fetch_book()) = readlines(IOBuffer(book.body))

function get_words(lines=get_lines())
    filter!(!isempty, lines)
    words = mapreduce(vcat, lines) do line
        split(line, r"[\s|\p{P}]+")
    end
    # remove empties from split
    filter!(!isempty, words)
    # remove trailing 's' from possesive dups
    filter!(!=("s"), words)
    return lowercase.(words)
end

unique_words = length ∘ unique

most_common_words = lowercase.(Set([
    "the", "be", "to", "of", "and", "a", "in", "that", "have", "I", "it", "for", "not",
    "on", "with", "he", "as", "you", "do", "at", "this", "but", "his", "by", "from", "they",
    "we", "say", "her", "she", "or", "an", "will", "my", "one", "all", "would", "there",
    "their", "what", "so", "up", "out", "if", "about", "who", "get", "which", "go", "me",
    "when", "make", "can", "like", "time", "no", "just", "him", "know", "take", "people",
    "into", "year", "your", "good", "some", "could", "them", "see", "other", "than", "then",
    "now", "look", "only", "come", "its", "over", "think", "also", "back", "after", "use",
    "two", "how", "our", "work", "first", "well", "way", "even", "new", "want", "because",
    "any", "these", "give", "day", "most", "us", "was", "is", "had", "were", "are"
]))

function most_popular(words=get_words(), n=20, common=most_common_words)
    filter!(word -> !in(word, common), words)
    frequencies = StatsBase.countmap(words)
    return last(collect(sort(frequencies, byvalue=true)), n)
end

function longest_word(book, n=20)
    words = unique(get_words(book))
    words_by_length = sort(words, by=length)
    return last(words_by_length, n)
end

ispalindrome(word) = word == reverse(word)

function longest_palindrome(book, n=20)
    words = filter(get_words(book)) do word
        ispalindrome(word)
    end
    return last(sort(unique(words), by=length), n)
end
