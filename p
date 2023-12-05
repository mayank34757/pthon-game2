ython.py
import pygame
import sys
import random

# Initialize Pygame
pygame.init()

# Set up display
width, height = 600, 400
win = pygame.display.set_mode((width, height))
pygame.display.set_caption("Snake Game")

# Colors
black = (0, 0, 0)
white = (255, 255, 255)
red = (255, 0, 0)

# Snake initial position and size
snake_size = 10
snake_speed = 15
snake = [[100, 50], [90, 50], [80, 50]]
direction = 'RIGHT'

# Initial food position
food_pos = [random.randrange(1, (width//10)) * 10, random.randrange(1, (height//10)) * 10]

# Function to draw the snake
def draw_snake(snake):
    for segment in snake:
        pygame.draw.rect(win, white, pygame.Rect(segment[0], segment[1], snake_size, snake_size))

# Function to draw the food
def draw_food(food_pos):
    pygame.draw.rect(win, red, pygame.Rect(food_pos[0], food_pos[1], snake_size, snake_size))

# Main game loop
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_UP and direction != 'DOWN':
                direction = 'UP'
            if event.key == pygame.K_DOWN and direction != 'UP':
                direction = 'DOWN'
            if event.key == pygame.K_LEFT and direction != 'RIGHT':
                direction = 'LEFT'
            if event.key == pygame.K_RIGHT and direction != 'LEFT':
                direction = 'RIGHT'

    # Move the snake
    if direction == 'UP':
        snake[0][1] -= snake_size
    if direction == 'DOWN':
        snake[0][1] += snake_size
    if direction == 'LEFT':
        snake[0][0] -= snake_size
    if direction == 'RIGHT':
        snake[0][0] += snake_size

    # Check for collision with the food
    if snake[0] == food_pos:
        food_pos = [random.randrange(1, (width//10)) * 10, random.randrange(1, (height//10)) * 10]
        snake.append([0, 0])

    # Check for collision with walls or itself
    if snake[0][0] < 0 or snake[0][0] >= width or snake[0][1] < 0 or snake[0][1] >= height:
        pygame.quit()
        sys.exit()

    for segment in snake[1:]:
        if segment == snake[0]:
            pygame.quit()
            sys.exit()

    # Move the tail
    for i in range(len(snake) - 1, 0, -1):
        snake[i] = snake[i - 1][:]

    # Draw everything
    win.fill(black)
    draw_snake(snake)
    draw_food(food_pos)
    pygame.display.flip()

    # Set the game speed
    pygame.time.Clock().tick(snake_speed)
