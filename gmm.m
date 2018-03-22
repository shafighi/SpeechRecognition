classdef gmm
   properties
        cov
        mean
        stateID
   end
   methods
       function obj = setID(obj,id)
          obj.stateID  = id; 
       end
       function norm = getP(obj,x)
            %norm = normpdf(x,obj.mean,diag(obj.cov)');
            size(x)
            size(obj.mean)
            size(obj.cov)
            d = diag(diag(obj.cov));
            norm = mvnpdf(x,obj.mean,d);           
       end
      function obj = update(obj,lamdas,os)
        m=zeros(1,size(os{1},2));
        c=zeros(size(os{1},2));
        summ =0;
        for k=1:size(os,1)
            for t=1:size(os{k},1)-1
                l1 = lamdas{k}(t,obj.stateID);
                m = m + repmat(l1,1,size(os{k},2)).*os{k}(t,:);
            end
        end
        for k=1:size(os,1)
            summ = summ + sum(sum(lamdas{k}));
        end
        %size(m)
        obj.mean=m./summ;
        
        for k=1:size(os,1)
            for t=1:size(os{k},1)-1
                temp = os{k}(t,:) - obj.mean;
                size(temp)
                l1 = lamdas{k}(t,obj.stateID).* (temp*temp');
                size(l1)
                c = c + l1;
            end
        end
        %c= diag(diag(c))
        obj.cov=c./summ;        
        
        
        %obj.cov=c;
      end
      function obj = initial(obj,mean,cov)
         obj.mean = mean;
%          temp=0;
%          for k=1:lenght(os)
%             temp = temp+ sum(os(k)*os(k)');
%          end
         obj.cov = cov;
      end
   end
end
