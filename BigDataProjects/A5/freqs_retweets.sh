#!/bin/bash
# Usage: ./freqs_retweets.sh retweets_userBs.txt all_retweeted.hashes.userB.txt all_retweets.txt
# Make sure this script is executable with: chmod +x freqs_retweets.sh

retweets_userBs_file=$1
all_retweeted_hashes_file=$2
all_retweets_file=$3

for userb in `cat $retweets_userBs_file`; do
    hashtags=`egrep $userb $all_retweeted_hashes_file | awk '{print $2}' | sed 's/"//g' | tr "," "\n"`
    for h in $hashtags; do
        count_H_in_C=`egrep $userb $all_retweeted_hashes_file | awk '{print $2}' | tr "," "\n" | egrep -c $h`
        count_tweets_in_C=`egrep -c $userb $all_retweeted_hashes_file`
        count_H_entire_dataset=`egrep -c $h $all_retweeted_hashes_file`
        count_tweets_entire_dataset=`wc -l $all_retweets_file | awk '{print $1}'`
        relative_frequency_H_C=`echo "scale=2; $count_H_in_C / $count_H_entire_dataset" | bc`
        frequency_H_C=`echo "scale=2; $count_H_in_C / $count_tweets_in_C" | bc`
        frequency_H_overall=`echo "scale=2; $count_H_entire_dataset / $count_tweets_entire_dataset" | bc`
        echo $h $userb $relative_frequency_H_C $frequency_H_C $frequency_H_overall $count_H_in_C $count_tweets_in_C $count_H_entire_dataset $count_tweets_entire_dataset
    done
done

