# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tsomchan <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/15 16:19:11 by tsomchan          #+#    #+#              #
#    Updated: 2024/04/24 00:39:52 by tsomchan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PRJ_PTH	=	../

CLIENT	=	client
SERVER	=	server

CLIENT_B	=	client_bonus
SERVER_B	=	server_bonus

CC		=	cc
CFLAGS	=	-Wall -Wextra -Werror
RM		=	rm -f
RM_RF	= 	rm -rf

all:
	make $@ --no-print-directory -C $(PRJ_PTH)

$(SERVER):
	make $@ -C $(PRJ_PTH)

$(CLIENT):
	make $@ -C $(PRJ_PTH)

clean:
	make $@ -C $(PRJ_PTH)

fclean:
	make $@ -C $(PRJ_PTH)

re:
	make $@ -C $(PRJ_PTH)

#	bonus

bonus:
	make $@ -C $(PRJ_PTH)

$(SERVER_B):
	make $@ -C $(PRJ_PTH)

$(CLIENT_B):
	make $@ -C $(PRJ_PTH)

#	Colors
NC			=	\033[0;0m
BLACK		=	\033[0;30m
D_RED		=	\033[0;31m
D_GREEN		=	\033[0;32m
D_YELLOW	=	\033[0;33m
D_BLUE		=	\033[0;34m
D_PURPLE	=	\033[0;35m
D_CYAN		=	\033[0;36m
L_GRAY		=	\033[0;37m
D_GRAY		=	\033[1;30m
L_RED		=	\033[1;31m
L_GREEN		=	\033[1;32m
L_YELLOW	=	\033[1;33m
L_BLUE		=	\033[1;34m
L_PURPLE	=	\033[1;35m
L_CYAN		=	\033[1;36m
WHITE		=	\033[1;37m

#	my additional rules

clear:
	@clear

norm:
	make $@ -C $(PRJ_PTH)

TRASH = .DS_Store

clean_more:
	$(RM_RF) $(TRASH)

#	git

git: git_add push

log: clear
	@git log --name-status -3

push:
	@git push
	-@clear && git log --name-status -1

git_add:
	@git add .
ifdef m
	@git commit -m "$(m)"
endif

.PHONY += clear norm clean_more git log push git_add

#	test

s: all
	./$(PRJ_PTH)$(SERVER)

sb: all bonus
	./$(PRJ_PTH)$(SERVER_B)

t: all
	./$(PRJ_PTH)client $(p) "$(t)"

TXT_PTH	=	txt/

#	./client $(p) "$(cat file)"

define run_txt
	@echo "$(D_YELLOW)Makefile: ./$(PRJ_PTH)client $(p)$$cat $(addprefix $(TXT_PTH), $1) $(NC)"
	./$(PRJ_PTH)client $(p) "$(shell cat $(addprefix $(TXT_PTH), $1))"
endef

define bonus_txt
	@echo "$(D_YELLOW)Makefile: ./$(PRJ_PTH)client_bonus $(p)$$cat $(addprefix $(TXT_PTH), $1) $(NC)"
	./$(PRJ_PTH)client_bonus $(p) "$(shell cat $(addprefix $(TXT_PTH), $1))"
endef

test_all: 100 emoji gr rus ukr 25k 50k thai jp 

test: all
ifdef txt
	@$(call run_txt, $(txt))
else
ifdef b
	@$(call bonus_txt, thai.txt)
else
	@$(call run_txt, thai.txt)
endif
endif

250k: all
ifdef b
	@$(call bonus_txt, 250k.txt)
else
	@$(call run_txt, 250k.txt)
endif

100: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

50k: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

25k: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

eng: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

jp: all
ifdef b
	@$(call bonus_txt, jp_hira.txt)
	@$(call bonus_txt, jp_kata.txt)
else
	@$(call run_txt, jp_hira.txt)
	@$(call run_txt, jp_kata.txt)
endif

rus: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

ukr: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

gr: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

thai: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

emoji: all
ifdef b
	@$(call bonus_txt, $@.txt)
else
	@$(call run_txt, $@.txt)
endif

n ?= 0

define repeat
	@n=$(n); \
	while [ $${n} -lt $2 ] ; do \
		n=`expr $$n + 1`; \
		echo "$(D_YELLOW)$$n Makefile: ./$(PRJ_PTH)client $(p)$$cat $(addprefix $(TXT_PTH), $1) $(NC)"; \
		./$(PRJ_PTH)client $(p) "$(shell cat $(addprefix $(TXT_PTH), $1))" ; \
	done; 
endef

multi_thai: all
	@$(call repeat, thai.txt, 20)

multi_50k: all
	@$(call repeat, 50k.txt, 20)

repeat: all
	@$(call repeat, $(txt), $(r))