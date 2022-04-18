library(LaplacesDemon)
library(tidyverse)
library(magrittr)
library(here)
#library(MetBrewer)
#library(purrr)
c_ESS <- function(param,n) {
  param[1:n] %>% LaplacesDemon::ESS()
}
data.table::fread(here("randomLogfile.log")) %>% as_tibble() -> aver
floor(nrow(aver) *  0.3) -> burnin
aver %<>% slice(-c(1:burnin))
seq(0,nrow(aver),10)[-1] -> n
purrr::map2(list(aver %>% select(Prior) %>% pull(Prior)),as.list(n),c_ESS) %>% unlist() -> prior
purrr::map2(list(aver %>% select(Likelihood) %>% pull(Likelihood)),as.list(n),c_ESS) %>% unlist() -> Likelihood
purrr::map2(list(aver %>% select(Posterior) %>% pull(Posterior)),as.list(n),c_ESS) %>% unlist() -> Posterior
purrr::map2(list(aver %>% select(clock_bg) %>% pull(clock_bg)),as.list(n),c_ESS) %>% unlist() -> clock_bg

tibble(Prior = prior,Posterior=Posterior,Likelihood=Likelihood,generation=n*10) %>% 
  pivot_longer(cols=-generation,names_to = "Parameter",values_to = "ESS") %>% 
ggplot(aes(x=generation,y=ESS,group=Parameter,color=Parameter)) +   geom_hline(yintercept = c(200),linetype="dashed") +
  geom_line(size=3) +
  MetBrewer::scale_color_met_d("Hiroshige") + theme(panel.background = element_blank(),panel.grid = element_blank(),axis.line=element_line(),plot.title=element_text(size=14, hjust=0, face="bold", color="black"),plot.subtitle=element_text(size=11, hjust=0, face="italic", color="black")) +
  labs(title="How does Effective Sample Size (ESS) vary across an MCMC chain?",subtitle="Cumulative estimates as a function of chain length",x="Chain length",y="Effective sample size") +
  NULL


