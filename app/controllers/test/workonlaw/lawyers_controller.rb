require 'rest-client'
require 'json'
# require 'date'

module Test

    module Workonlaw

        class LawyersController < ApplicationController

            def index

                url = "https://api.workon.law/technical_challenge/get_lawyers"
    
                @datos = RestClient.get url

            
                response = JSON.parse @datos.to_str
            
                # result = response['candidates'][0]['email']
            
                result = response
            
                render json:  result

            end

            def oldDate(value, hash )

                isOldDate = false

                hash.each do | h |

                    # puts "COMPROBANDO VALUE : #{value} y Hstart : #{h["start"]}"

                    if value.to_time.to_i <= h["start"].to_time.to_i

                        isOldDate = true

                        # puts "ENTRO VALUE <= H"

                    else

                        isOldDate = false

                        # puts "ENTRO EN EL ELSE"

                    end

                end

                return isOldDate
            end

            def show
                emailToSearch = params[:id]

                emailToSearch = emailToSearch.to_str

                url = "https://api.workon.law/technical_challenge/get_lawyers"
    
                @datos = RestClient.get url
            
                json_hash = JSON.parse @datos.to_str

                works_hash = json_hash["candidates"].map { |h| h['works'] if h['email'] == emailToSearch }.compact.first # => [1, 2, 3]

                timeWorking = 0

                continueProcesing = true

                works_hash.each_with_index do | works, index |

                    endTime = works["end"]

                    if continueProcesing

                        if works["end"] == nil

                            isOldDate = oldDate( works["start"], works_hash )
    
                            #Este IF aplica para el caso que si una fecha de inicio es la primera y ademas menor que todas,
                            #solo debe realizar el calculo para este rango de fechas.
                            if isOldDate && index == 0
    
                                continueProcesing = false
    
                            end
    
                            #======================

                            endTime = Time.now.strftime("%d-%m-%Y")

                        end

                        #Evaluar si la fecha inicial se encuentra dentro del rango de fechas de otro trabajo

                        dayCount = 0
                        dateInRange = false

                        # puts "=========  works_hash.each ============="
                        works_hash.each_with_index do | h, iH |

                            if index != iH

                                hStart  = h["start"].to_time.to_i

                                hEnd    = ( h["end"] == nil ) ? Time.now.strftime("%d-%m-%Y").to_i : h["end"].to_time.to_i
                                
                                whStart = works["start"].to_time.to_i

                                whEnd   = endTime.to_time.to_i

                                if hStart <= whStart && whStart <= hEnd

                                    if hStart <= whEnd && whEnd <= hEnd

                                        dayCount += 0

                                        dateInRange = true

                                    elsif whEnd > hEnd

                                        hEnd2 = ( h["end"] == nil ) ? Time.now.strftime("%d-%m-%Y") : h["end"]
                                        
                                        dayDif = ( Date.parse(endTime) - Date.parse(hEnd2) ).to_i

                                        dayCount += dayDif

                                        dateInRange = true

                                    end

                                end

                            end

                        end
    
                        # puts "=========  FIN works_hash.each ============="
                        
                        if dateInRange 

                            timeWorking += dayCount

                        else

                            dif = ( Date.parse(endTime) - Date.parse(works["start"]) ).to_i

                            timeWorking += dif

                        end                                          
                        
                    end

                end

                timeWorking = ( timeWorking.to_f / 365 ).round(1)


                render json: {

                    email: emailToSearch,
                    work_experience_years: timeWorking

                }, status: :ok

                
            end
        end

    end
end
