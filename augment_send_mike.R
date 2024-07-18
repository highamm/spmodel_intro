library(spmodel)
library(ggplot2)

binmod <- spglm(presence ~ elev * strat, data = moose,
                family = binomial, spcov_type = "cauchy")

## augment returns response .fitted no matter what type is specified to
## also, by default, if newdata is not specified, .fitted are on the response scale
augment(binmod, type = "link") |> pull(.fitted) |> summary() ## incorrect
augment(binmod, type = "response") |> pull(.fitted) |> summary() ## correct

fitted(binmod, type = "link") |> summary() ## correct
fitted(binmod, type = "response") |> summary() ## correct

## also, confidence intervals are not returned when asked for
augment(binmod, type = "link",
        se_fit = TRUE, interval = "confidence") ## returns se but no intervals


binmod_ind <- glm(presence ~ elev * strat, data = moose,
                  family = binomial)
library(broom)
augment(binmod_ind, type.predict = "link")
augment(binmod_ind, type.predict = "response")

augment(binmod_ind, interval = "confidence")
