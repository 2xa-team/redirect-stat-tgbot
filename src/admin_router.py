from aiogram import Router
from aiogram.types import Message

admin_router = Router(name=__name__)

@admin_router.message()
async def message_handler(message: Message):
    await message.answer('Hello from my router!')