# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flevesqu <flevesqu@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/01/22 00:33:10 by flevesqu          #+#    #+#              #
#    Updated: 2019/03/02 04:10:24 by flevesqu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RM = rm -f

LN = ln -fs

APPS =	describe\
		histogram\
		scatter_plot\
		pair_plot\
		logreg_train\
		logreg_predict\
		accuracy\

APPS_DIR = apps/

APPS_DEPENDANCIES =	$(APPS_DIR)error_handler/lib/error_handler.ex\
					$(APPS_DIR)describe/lib/describe.ex\
					$(APPS_DIR)describe/lib/describe.CLI.ex\
					$(APPS_DIR)describe/lib/describe.Feature.ex\
					$(APPS_DIR)describe/lib/describe.Feature.Informations.ex\
					$(APPS_DIR)parser/lib/parser.CSV.ex\
					$(APPS_DIR)display/lib/display.ex\
					$(APPS_DIR)display/lib/display.Describe.ex\
					$(APPS_DIR)histogram/lib/histogram.CLI.ex\
					$(APPS_DIR)histogram/lib/histogram.ex\
					$(APPS_DIR)scatter_plot/lib/scatter_plot.CLI.ex\
					$(APPS_DIR)scatter_plot/lib/scatter_plot.ex\
					$(APPS_DIR)plots/lib/plots.ex\
					$(APPS_DIR)datas/lib/datas.ex\
					$(APPS_DIR)pair_plot/lib/pair_plot.CLI.ex\
					$(APPS_DIR)pair_plot/lib/pair_plot.ex\
					$(APPS_DIR)wrapper/lib/wrapper.Python.ex\
					$(APPS_DIR)wrapper/lib/wrapper.Python.Agent.ex\
					$(APPS_DIR)logreg_predict/lib/logreg_predict.ex\
					$(APPS_DIR)logreg_predict/lib/logreg_predict.CLI.ex\
					$(APPS_DIR)logreg_predict/lib/logreg_predict.Parse.ex\
					$(APPS_DIR)logreg_train/lib/logreg_train.ex\
					$(APPS_DIR)logreg_train/lib/logreg_train.CLI.ex\
					$(APPS_DIR)logreg_train/lib/logreg_train.Thetas.ex\
					$(APPS_DIR)logreg_train/lib/logreg_train.Loss.ex\
					$(APPS_DIR)accuracy/lib/accuracy.ex\
					$(APPS_DIR)accuracy/lib/accuracy.CLI.ex\

all:  $(APPS)

describe: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

histogram: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

scatter_plot: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

pair_plot: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

logreg_train: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

logreg_predict: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

accuracy: $(APPS_DEPENDANCIES)
	cd $(APPS_DIR)$@; mix escript.build; cd -;$(LN) $(APPS_DIR)$@/$@ .

clean:
	mix clean

fclean: clean
	$(RM) $(APPS)
	$(RM) $(APPS_DIR)describe/describe
	$(RM) $(APPS_DIR)histogram/histogram
	$(RM) $(APPS_DIR)scatter_plot/scatter_plot
	$(RM) $(APPS_DIR)pair_plot/pair_plot
	$(RM) $(APPS_DIR)logreg_train/logreg_train
	$(RM) $(APPS_DIR)logreg_predict/logreg_predict
	$(RM) $(APPS_DIR)accuracy/accuracy
	$(RM) thetas.csv predictions.csv houses.csv

re: fclean all
