classdef hmm
   properties
      lamda;
      sequence;
      alpha;
      beta;
      zeta;
      alpha_new;
      beta_new;
      C;
      n;
      T;
      hmm_state;
   end
   methods
       function obj =  initial(obj,o)
            
            obj.T=length(o);          
       end
      function obj = forward(obj,o,states)
            %obj.n = size(states,1)
            obj.alpha = [];
            obj.alpha_new = [];
            for i=1:size(states,2)
                obj.alpha(1,i)=getP(states(i).Sgmm,o(1,:))*states(i).pi;
            end
            obj.C(1) = 1/sum(obj.alpha(1,:));
            %summm = 44
            %sum(obj.alpha(1,:))
            for i=1:size(states,2)
                obj.alpha_new(1,i) = obj.alpha(1,i)*obj.C(1);
            end
            %obj.alpha_new(1,:)
             %obj.C(1)
%              obj.alpha(1,:)
%              obj.alpha_new(1,:)
            for t=1:(obj.T-1)
                
                for j=1:size(states,2)
                    z=0;
                    for i=1:size(states,2)
                        aij=0;
                        for a=1:size(states(i).next,1)
                            if (states(i).next(a,1)==j)
                                aij = states(i).next(a,2);
                            end
                        end
                        z=z+obj.alpha_new(t,i)*aij;
%                         if(t==2 && j==1)
%                             haha= 0
%                             z
%                             aij
%                             obj.alpha_new(t,i)
%                         end
                    end
                    obj.alpha(t+1,j)=z*getP(states(j).Sgmm,o(t+1,:));
                    
%                     if (t==1  )
% %                         obj.alpha(t+1,j)
% %                         rio = 3
% %                         t+1
% %                         j
% %                         z
%                         getP(states(j).Sgmm,o(t+1,:))
% %                         o(t+1,:)
% %                         obj.alpha(t+1,j)
%                     end
                    if(sum(obj.alpha(t+1,:))==0)
                        obj.C(t+1) = 1;
%                         error = 1
                    else
                        obj.C(t+1) = 1/sum(obj.alpha(t+1,:));
                    end
                    obj.alpha_new(t+1,j) = obj.alpha(t+1,j)*obj.C(t+1);
%                     if(t==2 && j==1)
%                         hooy = 9
%                         sum(obj.alpha(t+1,:))
%                         obj.alpha(t+1,:)
%                         obj.C(t+1)
%                         obj.alpha_new(t+1,j)
%                     end
                end
            end
            %obj.alpha
            %obj.alpha_new

      end        
      function obj =  backward(obj,o,states)
            obj.beta = [];
            obj.beta_new = [];
            %obj.C
            for i=1:obj.n
                obj.beta_new(obj.T,i)=1*obj.C(obj.T);
            end
            for t=1:(obj.T-1)
                for j=1:obj.n
                    z=0;
                    for i=1:obj.n                       
                        aij=0;
                        for a=1:size(states(i).next,1)
                            if (states(i).next(a,1)==j)
                                aij = states(i).next(a,2);
                            end
                        end
                        z=z+obj.beta_new(t+1,j)*aij*getP(states(j).Sgmm,o(t+1,:));
                    end
                    obj.beta(t,i)=z;
                    obj.beta_new(t,i) = z*obj.C(t);
                end
            end
            
      end  
      function obj = set_lamda(obj)

          for t=1:obj.T-1
            for j=1:obj.n
                obj.lamda(t,j) = sum(obj.zeta(t,j,:));
            end
          end
      end
      function obj = set_zeta(obj,states,o)
          for t=1:obj.T-1
            for j=1:obj.n
                for i=1:obj.n
                    aij=0;
                    for a=1:size(states(i).next,1)
                        if (states(i).next(a,1)==j)
                            aij = states(i).next(a,2);
                        end
                    end
                    obj.zeta(t,i,j) = obj.beta_new(t+1,j)*obj.alpha_new(t,i)*getP(states(j).Sgmm,o(t+1,:))*aij;
                end
            end
          end
          %hh =0 
          %obj.beta_new
          %obj.alpha_new
          %obj.zeta
      end

      function obj = composeSentemceHMM(obj,sequence,states)
          hmm_state=[];
          counter = 0;
          hmm_state = [hmm_state;states(10)];
          hmm_state(counter+2) = states(11);
          hmm_state(counter+3) = states(12);
          hmm_state(counter+4) = states(13);
          hmm_state(counter+5) = states(14);
          hmm_state(counter+5).next = [14 0.75; counter+6 0.25];
          counter=counter+5; 
          pre =0;
          for i=1:size(sequence,2)
              if(sequence(i)=='a')
                  hmm_state(counter+1) = states(1);
                  hmm_state(counter+1).next = [counter+1 0.75;counter+2 0.25];
                  hmm_state(counter+2) = states(2);
                  hmm_state(counter+2).next = [counter+2 0.75;counter+3 0.25];
                  hmm_state(counter+3) = states(3);
                  if(sequence(i+1)==' ')
                     hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25/2;counter+9 0.25/2];
                  else
                     hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25];
                  end
                  counter = counter+3;
                  pre =1;
              end
              if(sequence(i)=='n')
                  hmm_state(counter+1) = states(4);
                  hmm_state(counter+1).next = [counter+1 0.75;counter+2 0.25];
                  hmm_state(counter+2) = states(5);
                  hmm_state(counter+2).next = [counter+2 0.75;counter+3 0.25];
                  hmm_state(counter+3) = states(6);
                  counter=counter+3;       
                  pre=2;
                  if(sequence(i+1)==' ')
                     hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25/2;counter+9 0.25/2];
                  else
                     hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25];
                  end
              end
              if(sequence(i)=='s')
                  hmm_state(counter+1) = states(7);
                  hmm_state(counter+1).next = [counter+1 0.75;counter+2 0.25];
                  hmm_state(counter+2) = states(8);
                  hmm_state(counter+2).next = [counter+2 0.75;counter+3 0.25];
                  hmm_state(counter+3) = states(9);
                  
                  counter=counter+3;     
                  pre =3;
                  if(sequence(i+1)==' ')
                     hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25/2;counter+9 0.25/2];
                  else
                     hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25];
                  end
              end
              if(sequence(i)==' ')
                  hmm_state(counter+1) = states(10);
                  hmm_state(counter+1).next = [counter+1 0.4;counter+2 0.3;counter+3 0.3];
                  hmm_state(counter+2) = states(11);
                  hmm_state(counter+2).next = [counter+2 0.4;counter+3 0.3;counter+4 0.3];
                  hmm_state(counter+3) = states(12);
                  hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25];
                  hmm_state(counter+4) = states(13);
                  hmm_state(counter+4).next = [counter+4 0.4;counter+3 0.3;counter+5 0.3];
                  hmm_state(counter+5) = states(14);
                  hmm_state(counter+5).next = [counter+5 0.75; counter+6 0.25];
                  counter=counter+5;                
                  pre =4;
              end
          end
          hmm_state(counter+1) = states(10);
          hmm_state(counter+1).next = [counter+1 0.4;counter+2 0.3;counter+3 0.3];
          hmm_state(counter+2) = states(11);
          hmm_state(counter+2).next = [counter+2 0.4;counter+3 0.3;counter+4 0.3];
          hmm_state(counter+3) = states(12);
          hmm_state(counter+3).next = [counter+3 0.75;counter+4 0.25];
          hmm_state(counter+4) = states(13);
          hmm_state(counter+4).next = [counter+4 0.4;counter+3 0.3;counter+5 0.3];
          hmm_state(counter+5) = states(14);
          hmm_state(counter+5).next = [counter+5 0.75; counter+6 0.25];
          hmm_state(counter+6) = states(15);
          hmm_state(counter+6).next = [counter+6 1];
          counter=counter+6; 
          obj.n = counter;
          obj.hmm_state = hmm_state;
          
      end
      function obj = path(obj,o,sequence,states_base)
          obj = initial(obj,o);
          obj = composeSentemceHMM(obj,sequence,states_base);
          %obj.hmm_state(1).Sgmm
          obj = forward(obj,o,obj.hmm_state);
          obj = backward(obj,o,obj.hmm_state);
          obj = set_zeta(obj,obj.hmm_state,o);
          obj = set_lamda(obj);
      end
   end
end