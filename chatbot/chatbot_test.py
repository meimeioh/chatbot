import os
import telebot

bot = telebot.TeleBot(os.environ['BOT_API_TOKEN'])

@bot.message_handler(commands=['start'])

def send_welcome(message):
    bot.reply_to(message, "Hi, I am Morchoo!")



bot.polling()


