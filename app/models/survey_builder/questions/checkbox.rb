module SurveyBuilder
    module Questions
        class Checkbox < Question

            def set_type
                self.type = self.class.name
            end

            def validate_answer
                question = parse_question_data
                Rails.logger.info "#{question}"
                answer = parse_answer_data(answer)
                answer.each do |key, ans|
                    ans.each do |option|
                        unless (key >= 0  && key < question.count && question[key]["options"].find_index(option))
                            raise SurveyBuilder::InvalidAnswerError
                        end
                    end
                end
            end

            def parse_question_data
                super
                
                # The format for the json question_data is as follows:
                # It will either be an array or an hash.
                # If array, it is supposed to be a list of multiple radio choice questions. Each element of array will be a hash as below.
                # If hash, it is a single question with radio choices.
                # Each hash will be have the following format.
                # {
                #   helper_text: ""
                #   options : ["A", "B", "C"]
                # }

                parsed_question = question_data
                if Hash == parsed_question.class
                    parsed_question = [parsed_question]
                end
                parsed_question.each_with_index do |question, index|
                    question["index"] = index
                end
                parsed_question
            end

            def parse_answer_data(answer)
                super(answer)
                # The answer_data is supposed to be a hash with index being the key and response being the list of values selected
                parsed_response = JSON.parse(answer.response)
                return parsed_response
            end
        end
    end
end