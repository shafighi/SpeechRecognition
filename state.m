classdef state
   properties
      phoneme_name;
      %Pstates;
      Sgmm;
      pi;
      stateID;
      next;
   end
   methods
       function obj = initial(obj,name,next,mean,cov,pi,id)
          obj.phoneme_name = name;
          obj.next = next;
          obj.pi = pi;
          obj.stateID = id;
          obj.Sgmm = gmm;
          obj.Sgmm = setID(obj.Sgmm,id);
          obj.Sgmm = initial(obj.Sgmm,mean,cov);
       end
      function obj =  update(obj,zetas,lamdas,os)
          obj.next = [];
          z=0;
          i = obj.stateID;
          for j=1:size(zetas{1},3)
                for k=1:size(zetas,2)
                    for t=1:size(zetas{1},1)
                        z =  z+zetas{k}(t,i,j); 
                    end         
                end
                total = 0;
                for (ss =1:size(lamdas))
                   total = total+sum(sum(lamdas{ss})) ;
                end
                obj.next= [obj.next;j z/total];
          end
          obj.Sgmm = update(obj.Sgmm,lamdas,os);
      end
   end
end