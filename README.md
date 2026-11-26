# Critters and You

![Critters and You](https://silasheaphy.dev/media/critters/still.webp)

Critters and You is a survival game built off a highly systemic and highly balanced ecosystem simulation. Players must navigate survival and extractive profit off a fully dynamic food chain. Hunting and selling creatures is necessary for profit, but go too far and the ecosystem itself collapses, leaving the entrepreneur to starve.

This game called for fine-tuning of systems. It brought the unique challenge of creating a system tuned to stay balanced in perpetuity on its own, but subject enough to instability that player actions could create a runaway impact. Design was built around pulling players in two opposite directions, one of moderation to ensure stability and the other of maximizing profit score.

**[Play it in your browser](https://yaleschoolofart.org/artofgame2026/students/Silas/critters.html)** · [Full case study](https://silasheaphy.dev/work/critters.html) · [Playtest write-up](https://docs.google.com/document/d/1-CkGf4vHsoWmlFZjPhMP-9rFeWjK6s2B44C4Kmb2IJQ/edit?usp=sharing) · [Miro board](https://miro.com/app/board/uXjVGms0Lnk=/?share_link_id=906650831798)

Solo project (design, programming, playtesting) in GameMaker, built spring 2026 as my final project for Art of the Game (ART 0907) at Yale.

## Seven species, one food chain

Grass grows and spreads across the map. Rabbits, mice and elk graze it. Coyotes hunt rabbits and mice, ferrets hunt mice, and wolves hunt elk, rabbits and coyotes. Each species has its own feeding rate, starvation threshold and breeding threshold, and every animal rolls slightly different values when it's born.

| Species | Starts at | Eats | Spear value |
|---|---|---|---|
| Rabbit | 50 | Grass | $2 |
| Mouse | 40 | Grass | $1 |
| Elk | 7 | Grass | $16 |
| Coyote | 4 | Rabbits, mice | $6 |
| Ferret | 4 | Mice | $3 |
| Wolf | 1 | Elk, rabbits, coyotes | $12 |

The simulation runs on a 128 × 72 grid with up to 1,500 animals.

## Stable on its own, fragile in your hands

The hard part was tuning a system that stays balanced indefinitely without a player, but that a player can still knock over. A handful of rules do most of the work:

- **Predators hunt by density.** A coyote looks five cells out for rabbits. If rabbits drop below 60% of their starting count, that radius shrinks. If they boom past double, it becomes unlimited.
- **Predators back off endangered prey.** When a prey species falls below a quarter of its starting count, predators steer away from it instead of toward it.
- **The last few predators hang on.** The last two coyotes can't starve, the last two ferrets can't starve while mice survive, and the last wolf can't starve while rabbits or elk are still around.
- **Wolves adapt.** A wolf that can't find elk searches again for rabbits, and it stops eating coyotes once only two are left.
- **Apex extinction is damped.** If coyotes and wolves both die out, grass growth and grazer feeding rates are slowly retuned to soften the population explosion that follows.

## Three rounds of playtesting

I ran three waves of playtests in April 2026 and stayed hands-off during each one, so the game had to explain itself.

1. **Classmates.** Nobody could read the game. I halved the default speed, darkened the grass so animals pop, and added a low-hunger warning, a spear crosshair, hard map borders to close an exploit, and a mini population graph.
2. **Classmates.** Readability was fixed (one tester rated their understanding of the ecosystem 9 out of 10), but the game felt "a little too solvable too quickly." I added a six-minute timer, a clear goal of making as much money as you can, and feeders and traps you buy and place for a specific species.
3. **Casual players in a dining hall.** Strategic depth was up and the learning curve held. I added a toggleable food chain chart, clearer labels, key prompts, a multi-screen tutorial, a title screen that shows the ecosystem running on its own, sound effects, and rules for edge cases when species go extinct.

## Opening the project

Open `CRITTERS.yyp` in GameMaker.

The simulation lives mostly in:
- `scripts/simulate_creatures`: feeding, hunting, starvation and breeding for every animal
- `scripts/simulate_grass_growth`: grass spread
- `scripts/create_creature`: per-species stats and birth variation
- `scripts/create_feeder_trap`: player-placed feeders and traps
- `scripts/draw_graph`: the population graphs
- `objects/obj_game`: game setup, the main loop and drawing
