function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
    fileId = fopen(nume, "r");
    N = fscanf(fileId, "%d", 1);
    for i=0:N
        a = fgetl(fileId);
    end
    val1 = fscanf(fileId, "%f", 1);
    val2 = fscanf(fileId, "%f", 1);
    
    fclose(fileId);
    
    PR1 = Iterative(nume, d, eps);  %Page Rank iterativ
    PR2 = Algebraic(nume, d);  %Page Rank algebraic
    
    fileId = fopen(nume + ".out", "w");
    fprintf(fileId, "%d\n\n", N);
    fprintf(fileId, "%f\n", PR1(:));  %scriu PR1 in fisier
    fprintf(fileId, "\n");
    fprintf(fileId, "%f\n", PR2(:));  %scriu PR2 in fisier
    fprintf(fileId, "\n");
    
    PR_1 = PR2;
    Indexes = [1:N];
    %ordonare indecsi si page rank score descrescator
    for i=1:N
       for j=1:N
        if PR_1(i) >= PR_1(j)
            [PR_1(j), PR_1(i)] = deal(PR_1(i), PR_1(j));
            [Indexes(j), Indexes(i)] = deal(Indexes(i), Indexes(j));
        end
       end
    end
    %afisare ranking
    for i=1:N
       fprintf(fileId, "%d %d %f\n", i, Indexes(i), Apartenenta(PR_1(i), val1, val2)); 
    end
    
    fclose(fileId);
end
