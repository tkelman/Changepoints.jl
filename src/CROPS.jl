# PELT for a range of penalties -- Make more efficient by recylcling comps , style of output?
# see http://arxiv.org/pdf/1412.3617.pdf

function CROPS(segment_cost::Function , n::Int64, pen::Array{Float64} )

    pen_interval = [ minimum(pen) , maximum(pen) ]

    # these are what we output
    out_num_cpts = []
    out_max_pen = []
    out_constrain = []
  
    while true

        stop = 0
        
        # do pelt and record no of chpts and
        # calculates the cost of the constrained problem
        # constrained (no of chpts = no_chpts[i])
        for i in 1:length(pen_interval)
            cpts , opt = PELT( segment_cost , n , pen_interval[i] )

            if ( in(length(cpts) , out_num_cpts ) )
                # find the index
                index = findin(out_nm_cpts,length(cpts))
                # check for penalty is it bigger than max penalty
                # index of pen_interval to delete BUT DELETED AFTER BREAKCONDITION
                if pen_interval[b] > out_max_pen[index]
                    # updated it
                    ''''''
                    ''''''
                else
                    # no change
                    stop+=1
                end
            else
                # penalty val has a no of chpts not been seen before
                # first store in output
                '''''
                ''''
                # then calc constrained like
                constrained_like[i] = opt - no_chpts[i]*pen_interval[i]
            end         
  
        end


        sort(out_num_cpts)
        sortperm(o)
        
        # condition to break while loop no new entries being put into out_num_cpts

        # leave loop and finish subject to output
        if stop == length(pen_interval)
            break
        end

        # NOWdelete items from pen_interval
        # look through out_num_cpts and calc beta_int and put these in pen_interval
        for i in 1:length(out_num_cpts)

            out_num_cpts[i]  out_num_cpts[i+1]

        end
        
        
    end

    return out

end


      # output dictionary
    out = ["no of chpts"=> Array(Int64,0), "penalty"=> Array((Float64,Float64),0), "optimum"=>  Array((Float64,Float64),0)]


## inside while loop previously
beta0 = pen_ranges[1]
        beta1 = pen_ranges[2]
        cpts_beta0 , opt_beta0 = PELT_general( segment_cost , n , beta0 )
        cpts_beta1 , opt_beta1 = PELT_general( segment_cost , n , beta1 )
        m0 = length(cpts_beta0) - 1
        m1 = length(cpts_beta1) - 1
    
        if m0 == m1
            # same no of chpts
            push!( out["no of chpts"] , m0  )
            push!( out["penalty"] , ( beta0  , beta1 )   )
            push!( out["optimum"] , ( opt_beta0  , opt_beta1 )   )
            # remove first two elements
            pen_ranges = pen_ranges[3:end]
        
        elseif m0 == m1 + 1
            # no of chpts differs by 1
            # find regions of penalty that give you required no of chpts
            # beta_int is intersection of lines
            beta_int = ( opt_beta1 - opt_beta0 + beta0*m0 - beta1*m1 )/(m0 - m1)
            push!( out["no of chpts"] , m0 , m1 )          
            push!( out["penalty"] , ( beta0  , beta_int ) , ( beta_int , beta1 )  )
            push!( out["optimum"] , ( opt_beta0  , opt_beta0 + m0*(beta_int - beta0) ) , ( opt_beta0 + m0*(beta_int - beta0), opt_beta1 )   )
            # remove first two elements
            pen_ranges = pen_ranges[3:end]
       
        else
            beta_int = ( opt_beta1 - opt_beta0 + beta0*m0 - beta1*m1 )/(m0 - m1)
            # do PELT at beta_int
            cpts_betaint , opt_betaint = PELT_general( segment_cost , n , beta_int )
            mint = length(cpts_betaint) - 1
            if mint !== m1
                push!( pen_ranges , beta0 , beta_int , beta_int , beta1 )
            end
            # remove first two elements
            pen_ranges = pen_ranges[3:end]
        end
#########################
