from aiogram import Router
from aiogram.types import Message

user_router = Router(name=__name__)

@user_router.message()
async def message_handler(message: Message):
    await message.answer('Hello from my router!')