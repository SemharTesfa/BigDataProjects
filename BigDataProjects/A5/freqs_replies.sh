#!/bin/bash
# Usage: ./freqs_replies.sh replies_userBs.txt replies_userBs_hashtags.txt replies_hashtags.txt
# Make sure this script is executable with: chmod +x freqs_replies.sh

replies_userBs_file=$1
replies_userBs_hashtags_file=$2
replies_hashtags_file=$3

for userb in `cat $replies_userBs_file`; do
    hashtags=`egrep $userb $replies_userBs_hashtags_file | awk '{print $1}' | sed 's/"//g' | tr "," "\n"`
    for h in $hashtags; do
        count_H_in_C=`egrep $userb $replies_userBs_hashtags_file | awk '{print $1}' | tr "," "\n" | egrep -c $h`
        count_tweets_in_C=`egrep -c $userb $replies_userBs_hashtags_file`
        count_H_entire_dataset=`egrep -c $h $replies_hashtags_file`
        count_tweets_entire_dataset=`egrep -c $h $replies_hashtags_file`
        relative_frequency_H_in_C=`echo "scale=2; $count_H_in_C / $count_H_entire_dataset" | bc`
        frequency_H_in_C=`echo "scale=2; $count_H_in_C / $count_tweets_in_C" | bc`
        frequency_H_overall=`echo "scale=2; $count_H_entire_dataset / $count_tweets_entire_dataset" | bc`
        echo $h $userb $relative_frequency_H_in_C $frequency_H_in_C $frequency_H_overall $count_H_in_C $count_tweets_in_C $count_H_entire_dataset $count_tweets_entire_dataset
    done
done
